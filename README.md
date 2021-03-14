# Desafio GOLANG do curso Full Cycle 2.0 - módulo Docker

## Conteúdo

- [Sobre](#sobre)
- [Utilização](#utilizando)
- [Etapas](#etapas)
- [Pesquisa](#pesquisa)

## Sobre <a name = "sobre"></a>

O Desafio consiste em criar um "Hello World" em GOLANG com o texto "Code.education Rocks!", compilar o programa e copiar o binário gerado em um entrypoint para uma imagem docker.

O Desafio também consiste em entregar uma imagem docker menor que 2MB publicada no docker hub, onde ao executar imprimirá o texto citado acima.


## Utilização <a name = "utilizando"></a>

### Pré requisitos

É necessário ter instalado o docker na máquina que for executar

### Execução
Para executar a imagem docker, rode o comando

```sh
docker run marcosmiklos/fullcycle-docker-challenge-go
```


## Etapas para resolução <a name = "etapas"></a>

Descrição das etapas utilizadas para chegar ao devido resultado:

### Etapa 1
Usando a imagem alpine do golang, gerando o binário e criando a imagem, resultou em um binário de 1.8MB e uma imagem docker de 302MB

#### Resultado:
```
- Binário GO: 1.8MB
- Imagem Docker: 302MB
```


### Etapa 2
Após pesquisar na internet e a dica do video onde o Wesley cita a imagem scratch, o binário permaneceu com o mesmo tamanho e a imagem docker ficou com 2.03MB
```dockerfile
RUN go build -o hellofullcycle .
```
#### Resultado:
```
- Binário GO: 1.8MB
- Imagem Docker: 2.03MB
```


### Etapa 3
Pesquisando sobre optimização de binários go, descobri que é possível usar ld flags para retirar informações de debug onde gerou um binário golang de 1.3mb e uma imagem docker de 1.39MB. Onde já satisfazia o desafio

```dockerfile
RUN go build -ldflags "-s -w" -o hellofullcycle .
```
#### Resultado:
```
- Binário GO: 1.3MB
- Imagem Docker: 1.39MB
```


### Etapa 4
A pesquisa feita, trazia uma informação a mais onde seria possível reduzir ainda mais a imagem final. Resolvi testar e funcionou.

A solução consistia em utilizar o upx "Ultimate Packer for eXecutables", que reduziu o binário golang para 428.3kb e a imagem docker em 447kB

```dockerfile
RUN apk add upx
RUN upx --brute hellofullcycle
```

#### Resultado Final:

```
- Binário GO: 428.3kb
- Imagem Docker: 447kB
```

## Pesquisa

Links pesquisados para resolução do desafio:

- [Hello Wolrd em GO](https://github.com/go-training/helloworld)
- [Docker Hub - Scratch Image](https://hub.docker.com/_/scratch)
- [Optimização do binário GO](https://blog.filippo.io/shrink-your-go-binaries-with-this-one-weird-trick/)
- [Adicionando Versão](https://www.digitalocean.com/community/tutorials/using-ldflags-to-set-version-information-for-go-applications-pt) (Não utilizado na resolução final)
