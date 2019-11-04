#!/bin/bash

KERNEL_VERSION=$(uname -a | sed -En "s/Darwin")

echo $KERNEL_VERSION
