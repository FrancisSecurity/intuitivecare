#!/bin/bash

ip="4hard.com.br"
hostname="docker-01"

#---Função que iniciar a stack de serviço, poderia deixar o caminho do arquivo YML como varivel e o nome da stack também

iniciar(){
       if [ "`/usr/bin/ssh -i ./chave -o ConnectTimeout=5 -q ubuntu@$ip sudo /bin/hostname`" != $hostname ]; then
                /bin/echo "ERRO!"
                /bin/echo ""
                exit 0
        else

            /usr/bin/ssh -i ./chave -o ConnectTimeout=5 -q  ubuntu@$ip sudo docker stack deploy -c /root/git/intuitivecare/docker-intuitive/Deploy.yml intuitive
           sleep 5
           echo -e "\nOs serviços abaixo foram iniciados"
           /usr/bin/ssh -i ./chave -o ConnectTimeout=5 -q  ubuntu@$ip sudo docker service ls
        fi
}


#---FUnção que conecta no cluster e encerra todas as stack, também tem um for para remover todas as stack
	
encerrar(){
    if [ "`/usr/bin/ssh -i ./chave -o ConnectTimeout=5 -q ubuntu@$ip sudo /bin/hostname`" != $hostname ]; then
                /bin/echo "ERRO!"
                /bin/echo ""
                exit 0
        else
            delete=$(/usr/bin/ssh -i ./chave -o ConnectTimeout=5 -q ubuntu@$ip sudo docker stack ls | cut -d " " -f 1 |grep -v NAME)

              for j in $delete
                 do
                        /usr/bin/ssh -i ./chave -o ConnectTimeout=5 -q  ubuntu@$ip sudo docker stack rm  $j
                 done
           echo " "
           echo "Todas as Stacks removidas"
            /usr/bin/ssh -i ./chave -o ConnectTimeout=5 -q ubuntu@$ip sudo docker stack ls
        fi
}

#--função que conectado no cluster para pegar o status do cluster, faz um for caso tenha mais uma stack rodando ele traz o status de todas

status(){
       if [ "`/usr/bin/ssh -i ./chave -o ConnectTimeout=5 -q ubuntu@$ip sudo /bin/hostname`" != $hostname ]; then
                /bin/echo "ERRO!"
                /bin/echo ""
                exit 0
          else
                  retorno=$(/usr/bin/ssh -i ./chave -o ConnectTimeout=5 -q ubuntu@$ip sudo docker stack ls | cut -d " " -f 1 |grep -v NAME)

                  for i in $retorno
                 do
                         echo "----------------------------------Stack $i ---------------------------------------------------------------------------------------------"
                        /usr/bin/ssh -i ./chave -o ConnectTimeout=5 -q  ubuntu@$ip sudo docker stack ps  $i

                        echo -e "--------------------------------------------------------------------------------------------------------------------------------------"
                        echo " "
                done
		
         fi
}



#---Menu para pegar a opção desejada
echo "Bem Vindo ao Gerenciador Cluster"
echo "  "
echo -e "Digite 1 para Iniciar  o Cluster\n""Digite 2 para Encerrar o Cluster\n""Digite 3 para Status do Cluster\n""Digite 4 para SAIR"
read valor




case $valor in
   1) 
	iniciar;;
	
   2) 
        encerrar;;
   3) 
        status;;

   4)   
	exit;;	

*) echo "Opcao Invalida!" ;;
esac


