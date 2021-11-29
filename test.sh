#!/bin/bash
function check_os_type() {
    dpkg -l ubuntu-desktop >> log.log
    awk '/ubuntu-desktop/{print $NF}' log.log 
}
check_os_type