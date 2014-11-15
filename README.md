# Mqtt

Just a simple mqtt server using vagrant and salt

## Generate your credentials

```
mosquitto_passwd -c base/salt/mosquitto.pwd walter
```

## Start the service

Actually the system uses 2 networks (internal and bridged)

```
vagrant up
```

## Test/Production

```
vagrant up --provider=openstack|aws|digital_ocean
```

