all:
	@docker-compose -f ./srcs/docker-compose.yml up --build

ps :
	@docker ps -a

exec:
	@bash ./exec.sh

clean:
	@docker-compose -f ./srcs/docker-compose.yml down --rmi all

fclean: clean
	docker network prune
	docker volume rm `docker volume ls -q`

re: fclean all

.PHONY: all ps exec clean fclean re