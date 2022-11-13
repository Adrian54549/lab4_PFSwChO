# Sprawozdanie - Laboratorium 4

## Test 3
Aby użyć pliku Dockerfile, który nie ma domyślnej nazwy "Dockerfile" stosujemy: ```--opt filename=nazwa_pliku```<br />
W oparciu o plik Dockerfile_test3, wykorzystując buildkit, budujemy obraz o nazwie test3 i przesyłamy go do swojego repozytorium na DockerHub:<br />
```buildctl build --ssh default=/mnt/c/Users/Adrian/.ssh/id_ed25519 --frontend=dockerfile.v0 --local context=. --local dockerfile=. --opt filename=Dockerfile_test3 --output type=image,name=docker.io/adrianszafranski/test3,push=true```<br />
Zrzut ekranu: [wykonanie komendy](https://github.com/Adrian54549/lab4_PFSwChO/blob/main/screenshots/test3.png)<br />
Obraz został przesłany do repozytorium DockerHub: https://hub.docker.com/r/adrianszafranski/test3

## Zadanie obowiązkowe
Uruchamiamy kontener z repozytorium obrazów poleceniem:<br />
```docker run -d -p 5000:5000 --restart always --name registry registry:2```<br />
Zrzut ekranu: [wykonanie komendy](https://github.com/Adrian54549/lab4_PFSwChO/blob/main/screenshots/zo_DockerRun.png)<br /><br />
Budujemy obraz za pomocą Buildkit (jak na lab) w taki sposób, że obraz i cache są przesyłane do lokalnego repozytorium oddzielnie:<br />
```buildctl build --ssh default=/mnt/c/Users/Adrian/.ssh/id_ed25519 --frontend=dockerfile.v0 --local context=. --local dockerfile=. --output type=image,name=localhost:5000/simpleweb:image,push=true --export-cache type=registry,ref=localhost:5000/simpleweb:buildcache```<br />
Zrzuty ekranu: [wykonanie komendy](https://github.com/Adrian54549/lab4_PFSwChO/blob/main/screenshots/buildImageCacheSeparately.png), 
[wynik komendy](https://github.com/Adrian54549/lab4_PFSwChO/blob/main/screenshots/imageSimpleweb.png)<br /><br />
Czyścimy cache: ```buildctl prune```<br />
Zrzut ekranu: [wykonanie komendy](https://github.com/Adrian54549/lab4_PFSwChO/blob/main/screenshots/cleanCache.png)<br /><br />
Ponownie budujemy obraz wykorzystując (pobierając) zapisane wcześniej dane z budowy obrazu: <br />
```buildctl build --ssh default=/mnt/c/Users/Adrian/.ssh/id_ed25519 --frontend=dockerfile.v0 --local context=. --local dockerfile=. --output type=image,name=localhost:5000/simpleweb:image2,push=true --export-cache type=registry,ref=localhost:5000/simpleweb:buildcache2 --import-cache type=registry,ref=localhost:5000/simpleweb:buildcache```<br />
Zrzut ekranu: [wykonanie komendy](https://github.com/Adrian54549/lab4_PFSwChO/blob/main/screenshots/importCache.png) - na zrzucie zaznaczona informacja o imporcie i wykorzystaniu cache<br /><br />
Analogiczne działanie <b>można</b> zrealizować w oparciu o własne, publiczne repozytorium na DockerHub.<br /> Aby to zrobić najpierw budujemy obraz za pomocą Buildkit w taki sposób, że obraz i cache są przesyłane do publicznego repozytorium na DockerHub: <br />
```buildctl build --ssh default=/mnt/c/Users/Adrian/.ssh/id_ed25519 --frontend=dockerfile.v0 --local context=. --local dockerfile=. --output type=image,name=docker.io/adrianszafranski/simpleweb:image,push=true --export-cache type=registry,ref=docker.io/adrianszafranski/simpleweb:buildcache```<br />
Zrzut ekranu: [wykonanie komendy](https://github.com/Adrian54549/lab4_PFSwChO/blob/main/screenshots/buildImageCacheSaparatelyPublicDockerhubRepository.png)<br /><br />
Czyścimy cache: ```buildctl prune```<br />
Zrzut ekranu: [wykonanie komendy](https://github.com/Adrian54549/lab4_PFSwChO/blob/main/screenshots/cleanCachePublicDockerhubRepository.png)<br /><br />
Ponownie budujemy obraz wykorzystując (pobierając) zapisane wcześniej dane z budowy obrazu: <br />
```buildctl build --ssh default=/mnt/c/Users/Adrian/.ssh/id_ed25519 --frontend=dockerfile.v0 --local context=. --local dockerfile=. --output type=image,name=docker.io/adrianszafranski/simpleweb:image2,push=true --export-cache type=registry,ref=docker.io/adrianszafranski/simpleweb:buildcache2 --import-cache type=registry,ref=docker.io/adrianszafranski/simpleweb:buildcache```<br />
Zrzut ekranu: [wykonanie komendy](https://github.com/Adrian54549/lab4_PFSwChO/blob/main/screenshots/importCachePublicDockerhubRepository.png) - na zrzucie zaznaczona informacja o imporcie i wykorzystaniu cache<br /><br />
Obrazy zostały przesłane do repozytorium DockerHub: https://hub.docker.com/r/adrianszafranski/simpleweb

## Zadanie dodatkowe
Tryb eksportowania cache 'min' eksportuje tylko warstwy wynikowego obrazu.<br />
Tryb eksportowania cache 'max' eksportuje wszystkie warstwy wszystkich etapów pośrednich.<br /><br />
Budujemy obraz(za pomocą Buildkit, do publicznego repozytorium na dockerHub) przechowując cache lokalnie i wykorzystując tryb eksportowania 'min':<br />
```buildctl build --ssh default=/mnt/c/Users/Adrian/.ssh/id_ed25519 --frontend=dockerfile.v0 --local context=. --local dockerfile=. --output type=image,name=docker.io/adrianszafranski/zaddodatkowe:min,push=true --export-cache type=local,dest=.,mode=min```<br />
Zrzut ekranu: [wykonanie komendy](https://github.com/Adrian54549/lab4_PFSwChO/blob/main/screenshots/buildImageCacheLocallyUseMin.png)<br /><br />
Czyścimy cache: ```buildctl prune```<br />
Zrzut ekranu: [wykonanie komendy](https://github.com/Adrian54549/lab4_PFSwChO/blob/main/screenshots/cleanCacheUseMin.png)<br /><br />
Ponownie budujemy obraz wykorzystując zapisany wcześniej lokalny cache: <br />
```buildctl build --ssh default=/mnt/c/Users/Adrian/.ssh/id_ed25519 --frontend=dockerfile.v0 --local context=. --local dockerfile=. --output type=image,name=docker.io/adrianszafranski/zaddodatkowe:min2,push=true --import-cache type=local,src=.```<br />
Zrzut ekranu: [wykonanie komendy](https://github.com/Adrian54549/lab4_PFSwChO/blob/main/screenshots/importCacheLocallyUseMin.png)<br /><br />
Robimy te same czynności dla trybu eksportowania cache 'max'.<br />
Najpierw budujemy obraz(za pomocą Buildkit, do publicznego repozytorium na dockerHub) przechowując cache lokalnie i wykorzystując tryb eksportowania 'max':<br />
```buildctl build --ssh default=/mnt/c/Users/Adrian/.ssh/id_ed25519 --frontend=dockerfile.v0 --local context=. --local dockerfile=. --output type=image,name=docker.io/adrianszafranski/zaddodatkowe:max,push=true --export-cache type=local,dest=.,mode=max```<br />
Zrzut ekranu: [wykonanie komendy](https://github.com/Adrian54549/lab4_PFSwChO/blob/main/screenshots/buildImageCacheLocallyUseMax.png)<br /><br />
Czyścimy cache: ```buildctl prune```<br />
Zrzut ekranu: [wykonanie komendy](https://github.com/Adrian54549/lab4_PFSwChO/blob/main/screenshots/cleanCacheUseMax.png)<br /><br />
Ponownie budujemy obraz wykorzystując zapisany wcześniej lokalny cache: <br />
```buildctl build --ssh default=/mnt/c/Users/Adrian/.ssh/id_ed25519 --frontend=dockerfile.v0 --local context=. --local dockerfile=. --output type=image,name=docker.io/adrianszafranski/zaddodatkowe:max2,push=true --import-cache type=local,src=.```<br />
Zrzut ekranu: [wykonanie komendy](https://github.com/Adrian54549/lab4_PFSwChO/blob/main/screenshots/importCacheLocallyUseMax.png)<br />
Obrazy zostały przesłane do repozytorium DockerHub: https://hub.docker.com/r/adrianszafranski/zaddodatkowe

## Zbiorcze linki do DockerHub

Test3: https://hub.docker.com/r/adrianszafranski/test3<br />
Zadanie obowiązkowe: https://hub.docker.com/r/adrianszafranski/simpleweb<br />
Zadanie dodatkowe: https://hub.docker.com/r/adrianszafranski/zaddodatkowe
