NAME = inception

all: $(NAME)

$(NAME):
	bash ./scripts/install.sh

clean:
	docker compose down

fclean: clean
	rm .config
	docker system prune -af

re: fclean all

.PHONY: all $(NAME) clean fclean re
