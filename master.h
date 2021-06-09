#ifndef MASTER_H
# define MASTER_H

# include <stdlib.h>
# include <stdio.h>
# include <signal.h>
# include <sys/types.h> 
# include <unistd.h>

# define NB_SIG 8
# define BUFFER_SIZE 32

int		ft_atoi(char *s);
void	ft_putchar(char c);
void	ft_putstr(char *s);
void	ft_putnbr(int nb);

void	add_char_to_buffer(char c);

int		send_str(pid_t serv_pid, char *s);
int		received_signal(int set_to_true);
void	client_signal_handler(int signum);

#endif