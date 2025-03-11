# Firewall Script

Este repositorio contiene un script de firewall en Bash (`firewall.sh`) diseñado para configurar reglas de `iptables` y `ip6tables` con políticas de seguridad restrictivas.

## Descripción

El script realiza las siguientes acciones:
- Define direcciones IP de servidores y VPNs.
- Limpia las reglas existentes en `iptables` y `ip6tables`.
- Aplica políticas restrictivas, bloqueando tráfico de entrada y permitiendo tráfico de salida.
- Permite tráfico loopback y conexiones establecidas.
- Aplica reglas específicas para IPv4 e IPv6.
- Pasados 30 segundos se borran las reglas existentes y se aplican políticas de seguridad permisivas.

## Uso

Para ejecutar el script, usa el siguiente comando con permisos de superusuario:

```bash
sudo ./firewall.sh
```

## Requisitos
- Sistema operativo basado en Linux.
- Paquetes `iptables` y `ip6tables` instalados.
- Permisos de superusuario para modificar reglas de firewall.

## Advertencia
Este script aplica reglas estrictas de firewall que pueden bloquear tráfico importante si no se configuran correctamente las excepciones necesarias. Se recomienda revisar y adaptar las reglas antes de ejecutarlo en un entorno de producción.

