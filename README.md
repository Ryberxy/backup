# BACKUP DEBIAN13
Se trata de una estructura de script bash en Linux, concretamente en debian. 

Se contemplan las copias de seguridad completa e incremental, programadas para ejecutarse en el día adecuado mediante un servicio y un timer que lo controla.

Es recomendable ubicar el directorio con los scripts en /usr/local/sbin


## CONFIGURACIÓN

Simplemente tienes que mover el servicio a /etc/systemd/system y configurarlo con la ruta de donde se encuentre tu backup_launcher.sh, no te hará falta configurar la ruta si tienes tu directorio backup en /usr/local/sbin.

### Mover servicio y timer:

<pre>
  mv servicios/backup.service /etc/systemd/system/
  mv servicios/backup.timer /etc/systemd/system/
</pre>

### Habilitar el timer:

<pre>
  systemctl daemon-reload
  systemctl enable --now backup.timer
</pre>
