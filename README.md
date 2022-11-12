# Sprawozdanie - Laboratorium 4

## Test 3
Aby użyć pliku Dockerfile, który nie ma domyślnej nazwy "Dockerfile" stosujemy: ```--opt filename=nazwa_pliku```<br />
W oparciu o plik Dockerfile_test3, wykorzystując buildkit, budujemy obraz o nazwie test3 i przesyłamy go do swojego repozytorium na DockerHub:<br />
```buildctl build --ssh default=/mnt/c/Users/Adrian/.ssh/id_ed25519 --frontend=dockerfile.v0 --local context=. --local dockerfile=. --opt filename=Dockerfile_test3 --output type=image,name=docker.io/adrianszafranski/test3,push=true```<br />
![Test3](https://github.com/Adrian54549/lab4_PFSwChO/blob/main/screenshots/test3.png)<br />
Obraz został przesłany do repozytorium DockerHub: https://hub.docker.com/r/adrianszafranski/test3
