#! /vendor/bin/sh

# Copyright (C) 2020 Paranoid Android
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Wait to set proper init values
sleep 20

# Report max frequency to unity tasks.
echo "UnityMain,libunity.so" > /proc/sys/kernel/sched_lib_name
echo "255" > /proc/sys/kernel/sched_lib_mask_force

# Sched Tunables.
echo "0" > /proc/sys/kernel/sched_autogroup_enabled
echo "65" > /proc/sys/kernel/sched_downmigrate
echo "50" > /proc/sys/kernel/sched_downmigrate_boosted
echo "70" > /proc/sys/kernel/sched_upmigrate
echo "70" > /proc/sys/kernel/sched_upmigrate_boosted

# Setup cpusets
echo "0-7" > /dev/cpuset/top-app/cpus
echo "0-2,5-7" > /dev/cpuset/foreground/cpus
echo "0-3" > /dev/cpuset/background/cpus
echo "0-3" > /dev/cpuset/system-background/cpus

# Setup blkio.
echo "1000" > /dev/blkio/blkio.weight
echo "200" > /dev/blkio/background/blkio.weight
echo "2000" > /dev/blkio/blkio.group_idle
echo "0" > /dev/blkio/background/blkio.group_idle

# Setup default schedTune value for foreground/top-app
echo "1" > /dev/stune/foreground/schedtune.prefer_idle
echo "10" > /dev/stune/top-app/schedtune.boost
echo "1" > /dev/stune/top-app/schedtune.prefer_idle

# Setup EAS Tunables.
echo "1000" > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
echo "1000" > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us

echo "1000" > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/up_rate_limit_us
echo "1000" > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/down_rate_limit_us

echo "Boot Evie Pelt completed " >> /dev/kmsg

