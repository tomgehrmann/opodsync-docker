# opodsync-docker

Automated container image builds for [oPodSync](https://github.com/kd2org/opodsync), a gPodder API compatible server previously known as Micro GPodder Server.

## Installation

> [!warning]
> Do **not** use this image in an untrusted environment! The image uses the php development server.

A compose file is provided.

```yaml:compose.yaml
```

### Notes

* Although the php dev server is used, apart from that basic best practices are being employed. Adjust the values to suit your setup.
* The user of the application has the UID/GID `1000` by default. If you want to use another user, you need to define this explicitly in the compose file. In any case, be aware of file permissions.

## Contributions and Maintenance
The builds are fully automated, so I will not be actively maintaining this.
Contributions are welcome, but I cannot promise timely replies.