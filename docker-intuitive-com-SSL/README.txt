Para subir a stack usando certificado gerado pelo letsencript pela primeir vez deve subir a stack e depois executar o docker-compose para inicicar o contaner certbot que gera os certificados, esse container não fica em execução.

Ao subir a stack pela primeira vez deve ser criado a rede no formato overlay, pois é a rede do swarm, abaixo os passos

mkdir dhparam certbot


docker network create --subnet=172.10.0.0/24  -d overlay intituite

docker stack deploy -c Deploy.yml  NOME-de-sua-escolha
EX: docker stack deploy -c Deploy.yml  intuitive

docker-compose up -d


com os passos acima  stack já está rodando com certificado ssl


