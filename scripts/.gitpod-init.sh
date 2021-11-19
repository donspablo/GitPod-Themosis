#!/bin/bash
RUN sudo  ssh-keygen -q -t rsa -N '' <<< $'\ny' >/dev/null 2>&1