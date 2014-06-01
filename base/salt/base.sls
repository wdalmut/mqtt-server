build-essential:
    pkg:
        - installed
curl:
    pkg:
        - installed
git:
    pkg:
        - installed

sysstat:
    pkg:
        - installed

vim:
    pkg:
        - installed

python-software-properties:
    pkg:
        - installed

mosh:
    pkgrepo.managed:
        - ppa: keithw/mosh
    pkg.latest:
        - name: mosh
        - refresh: True

