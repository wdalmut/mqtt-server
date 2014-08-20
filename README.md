# Mqtt

Just a simple mqtt server using vagrant and salt

## Generate your credentials

```
mosquitto_pwd -c base/salt/mosquitto.pwd walter
```

## Start the service

Actually the system uses 2 networks (internal and bridged)

```
vagrant up
```

## Test/Production

```
vagrant up --provider=openstack|aws|digitalocean
```

