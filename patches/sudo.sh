#!/bin/bash

cygstart --action=runas --wait \
    bash --login -c "'""$@""'"


