# SPDX-License-Identifier: BSD-3-Clause
# Copyright(c) 2017 Intel Corporation

arch_headers = files(
        'rte_atomic.h',
        'rte_byteorder.h',
        'rte_cpuflags.h',
        'rte_cycles.h',
        'rte_io.h',
        'rte_memcpy.h',
        'rte_pause.h',
        'rte_power_intrinsics.h',
        'rte_prefetch.h',
        'rte_rtm.h',
        'rte_rwlock.h',
        'rte_spinlock.h',
        'rte_vect.h',
)
arch_indirect_headers = files(
        'rte_atomic_32.h',
        'rte_atomic_64.h',
        'rte_byteorder_32.h',
        'rte_byteorder_64.h',
)
install_headers(arch_headers + arch_indirect_headers, subdir: get_option('include_subdir_arch'))
dpdk_chkinc_headers += arch_headers
