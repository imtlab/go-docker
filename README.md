# A Golang image based on imtlab/baseimage

## Baseiamge Versioning
The versioning of the Golang image tag is a combination of the Golang version and the base image version. For example, a Golang image that is running 1.12 with a baseimage version of 18.0.0 would look like the following: 
`imtlab/baseimage-golang:1.12-18.0.0`. 

In rare events, the Golang image will need to be extended independently of a baseimage update. When that happens, it is best to add a hyphen and an incrementing interger to the base image version. For example:
`imtlab/baseimage-golang:1.12-18.0.0-1`

## Golang Versioning
Golang will release new versions from time to time and those versions will need to be added to both the `Makefile` and `.gitlab-ci.yml`. See existing examples on how to format for the new release. Also, make sure to updated `tag_latest` in the `Makefile` to match the lastest release of Golang. 

If a new Golang version is being built, it would also be a good idea to update the PATCH release of the base image. That way the new and existing Golang builds can take advantage of the latest security fixes and libraries.