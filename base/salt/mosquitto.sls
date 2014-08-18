mosquitto:
    pkgrepo.managed:
        - ppa: mosquitto-dev/mosquitto-ppa
    pkg.latest:
        - name: mosquitto
        - refresh: True
    service:
        - running
        - require:
            - pkg: mosquitto
        - watch:
            - pkg: mosquitto
            - file: /etc/mosquitto/mosquitto.conf

/etc/mosquitto/mosquitto.conf:
    file.managed:
        - source: salt://mosquitto.conf
        - user: root
        - group: root
        - mode: 0644

/etc/mosquitto/mosquitto.pwd:
    file.managed:
        - source: salt://mosquitto.pwd
        - user: root
        - group: root
        - mode: 0644

