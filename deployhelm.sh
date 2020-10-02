#!/bin/sh
#for helm version 3
#on namespaces enterpris-gateway
helm upgrade --install jupyterhub . --namespaces enterprise-gateway
