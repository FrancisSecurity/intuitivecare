para subir a stack pela primeira vez terá de criar a rede do tipo overlay, rede do tipo swarm,pois no arquivo foi especificado para usar uma rede externa existente, abaixo os passos para inciar


docker network create --subnet=172.10.0.0/24  -d overlay intituite
docker stack deploy -c Deploy.yml intuitite


