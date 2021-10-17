#!/bin/bash

_iselevated(){ if net session >/dev/null 2>&1;then return;fi;return 1;};_iselevated

