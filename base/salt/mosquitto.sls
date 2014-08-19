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

/etc/mosquitto/mosquitto.pwd:
    file.managed:
        - source: salt://mosquitto.pwd
        - user: root
        - group: root
        - mode: 0644
        - watch_in:
            - service: mosquitto

/etc/mosquitto/mosquitto.conf:
    file.managed:
        - source: salt://mosquitto.conf
        - user: root
        - group: root
        - mode: 0644
        - watch_in:
            - service: mosquitto

