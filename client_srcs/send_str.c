#include "master.h"

static int	send_signal(pid_t serv_pid, int sig)
{
	if (sig)
		return (kill(serv_pid, SIGUSR2));
	return (kill(serv_pid, SIGUSR1));
}

static int	send_char(pid_t serv_pid, unsigned char c)
{
	int	n;

	n = NB_SIG;
	while (n)
	{
		n--;
		if (send_signal(serv_pid, (int)c & (1 << n)))
			return (1);
		while (!received_signal(0))
			continue ;
	}
	return (0);
}

int	send_str(pid_t serv_pid, char *s)
{
	ft_putstr("Sending characters...\n");
	while (*s)
	{
		if (send_char(serv_pid, *s))
			return (1);
		s++;
	}
	ft_putstr("Characters has been received, sending EOT...\n");
	return (send_char(serv_pid, 0));
}
