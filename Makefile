NAME	= minitalk

# Files
SERV_SRCS	= buffer.c main.c
SERV_SRCS	:= $(SERV_SRCS:%.c=server_srcs/%.c)
SERV_OBJS	= $(SERV_SRCS:%.c=%.o)

CLIENT_SRCS	= main.c send_str.c signal.c
CLIENT_SRCS	:= $(CLIENT_SRCS:%.c=client_srcs/%.c)
CLIENT_OBJS	= $(CLIENT_SRCS:%.c=%.o)

COMMON_SRCS = ft_atoi.c ft_put.c
COMMON_SRCS	:= $(COMMON_SRCS:%.c=srcs/%.c)
COMMON_OBJS	= $(COMMON_SRCS:%.c=%.o)

SRCS	= $(SERV_SRCS) $(CLIENT_SRCS) $(COMMON_SRCS)
OBJS	= $(SERV_OBJS) $(CLIENT_OBJS) $(COMMON_OBJS)

INCS	= master.h

# Compilation
CC		= gcc
CFLAGS	= -Wall -Wextra -Werror -I.

# Colors
ERASE	= \033[2K\r
RED		= \033[31m
GREEN	= \033[32m
CYAN	= \033[36m
WHITE	= \033[37m
DEFAULT	= \033[0m
BOLD	= \033[1m

# Messages
INTRO_W		= $(BOLD)$(ERASE)$(RED)$(NAME)$(WHITE) : 
INTRO_G		= $(INTRO_W)$(GREEN)
SINTRO_W	= $(BOLD)$(ERASE)$(RED)$(NAME)$(WHITE) (server) : 
SINTRO_G	= $(SINTRO_W)$(GREEN)
CINTRO_W	= $(BOLD)$(ERASE)$(RED)$(NAME)$(WHITE) (client) : 
CINTRO_G	= $(CINTRO_W)$(GREEN)
E			= $(DEFAULT)
FORM_SERV	= $(CYAN)'server'$(WHITE)
FORM_CLIENT	= $(CYAN)'client'$(WHITE)
$(shell printf "" > .compiled_files)

# Norme
NORME_DIRS	= .

all:	$(NAME)

$(NAME):	server client

bonus:	$(NAME)

server:	$(SERV_OBJS) $(COMMON_OBJS)
	count=$$(cat .compiled_files | wc -w | sed -e 's/ //g'); \
	if [ "$$count" = "0" ]; then \
		printf "$(SINTRO_W)No object compiled$(E)\n"; \
	else \
		printf "$(SINTRO_G)$$count object(s) compiled$(E)\n"; \
	fi
	printf "" > .compiled_files
	printf "$(SINTRO_W)Compiling $(CYAN)'$@'$(WHITE)...$(E)"
	$(CC) $^ -o $@
	printf "$(SINTRO_G)Made$(E)\n"

client:	$(CLIENT_OBJS) $(COMMON_OBJS)
	count=$$(cat .compiled_files | wc -w | sed -e 's/ //g'); \
	if [ "$$count" = "0" ]; then \
		printf "$(CINTRO_W)No object compiled$(E)\n"; \
	else \
		printf "$(CINTRO_G)$$count object(s) compiled$(E)\n"; \
	fi
	printf "" > .compiled_files
	printf "$(CINTRO_W)Compiling $(CYAN)'$@'$(WHITE)...$(E)"
	$(CC) $^ -o $@
	printf "$(CINTRO_G)Made$(E)\n"

%.o:	%.c $(INCS)
	printf "$(INTRO_W)Compiling $(CYAN)'$@'$(WHITE)...$(E)"
	$(CC) $(CFLAGS) -c $< -o $@
	echo $@ >> .compiled_files

clean:
	printf "$(INTRO_W)Removing files...$(E)"
	count=$$(rm -rfv $(OBJS) | wc -w | sed -e 's/ //g'); \
	if [ "$$count" = "0" ]; then \
		printf "$(INTRO_W)No file$(E)\n"; \
	else \
		printf "$(INTRO_G)$$count file(s) deleted$(E)\n"; \
	fi

fclean:	clean
	printf "$(INTRO_W)Removing $(FORM_SERV)...$(E)"
	count=$$(rm -rfv server | wc -w | sed -e 's/ //g'); \
	if [ "$$count" = "0" ]; then \
		printf "$(INTRO_W)No file $(FORM_SERV)$(E)\n"; \
	else \
		printf "$(INTRO_G)$(FORM_SERV)$(GREEN) deleted$(E)\n"; \
	fi
	printf "$(INTRO_W)Removing $(FORM_CLIENT)...$(E)"
	count=$$(rm -rfv client | wc -w | sed -e 's/ //g'); \
	if [ "$$count" = "0" ]; then \
		printf "$(INTRO_W)No file $(FORM_CLIENT)$(E)\n"; \
	else \
		printf "$(INTRO_G)$(FORM_CLIENT)$(GREEN) deleted$(E)\n"; \
	fi

re:	fclean all

n:
	printf "Checking norme in $$(printf "$(NORME_DIRS)" | sed "s/ /, /g")\n"
	NORM=$$(/usr/bin/norminette $(NORME_DIRS)); \
	NORM_ERR=$$(printf "$$NORM" | grep -e Error\: | wc -l \
			| sed "s/ //g"); \
	if [ "$$NORM_ERR" = "0" ]; then \
			printf "Everything seems normed!\n"; \
	else \
			NORM_FIL=$$(printf "$$NORM" | grep -e Error\! \
					| wc -l | sed "s/ //g"); \
			printf "\n\t$$NORM_ERR error(s) in $$NORM_FIL file(s):\n\n"; \
			printf "$$(printf "$$NORM" | grep -e Error)\n"; \
	fi

.PHONY:		$(NAME) all clean fclean re n
.SILENT:	$(NAME) server client all $(OBJS) clean fclean n
