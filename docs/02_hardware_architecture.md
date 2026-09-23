# Section 2: Hardware Architecture & P4 ASIC Pipeline

## System Architecture Diagram

```

+-----------------------------------------------------------------------------------+
|                        P4 Fast-Path Pipeline & CXL Fabric                         |
+-----------------------------------------------------------------------------------+
Ingress Packets
│
▼
+-----------------------+      EtherType == 0x88F7      +---------------------------+
| P4 Ingress Parser     | ────────────────────────────> | Match-Action Table        |
| - Inspects Ethernet   |                               | - Resolves CXL Handle     |
|   Header              |                               | - Sets Traffic Class = 7  |
+-----------------------+                               +---------------------------+
│                                                              │
│ Standard Frames (0x0800)                                     │ CXL Memory Handle
▼                                                              ▼
+-----------------------+                               +---------------------------+
| Standard IP Engine    |                               | CXL 3.0 Type-3 Pool       |
| - Kernel SKB Buffers  |                               | - Zero-Copy DMA Write     |
| - Interrupt Overhead  |                               | - Hardware Page Pre-Map   |
+-----------------------+                               +---------------------------+

```

## P4 Metadata Header Structure
Fast-path frames carry a custom CXL fast-path encapsulation header:

```p4
header cxl_fastpath_t {
    bit<48> dst_mac;
    bit<48> src_mac;
    bit<16> ether_type;          // Must equal 0x88F7
    bit<32> cxl_memory_handle;   // Direct physical memory offset ID
    bit<16> transit_node_id;     // Ingress node origin identifier
}

```

## Fast-Path Match-Action Table Specification

```p4
table t_cxl_fastpath_routing {
    key = {
        hdr.cxl_fastpath.ether_type          : exact;
        hdr.cxl_fastpath.transit_node_id     : exact;
    }
    actions = {
        a_direct_cxl_dma_dispatch;
        a_fallback_standard_ip;
    }
    default_action = a_fallback_standard_ip();
}

action a_direct_cxl_dma_dispatch(bit<32> target_handle) {
    meta.cxl_dma_enable = 1;
    meta.target_cxl_handle = target_handle;
    standard_metadata.priority = 3'b111; // URLLC Priority
}

```
