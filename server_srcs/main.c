#include "master.h"

void	signal_handler(int signum, siginfo_t *info, void *ucontext)
{
	static int		n = NB_SIG;
	static pid_t	last_pid = 0;
	static char		c = 0;

	(void)ucontext;
	c <<= 1;
	if (signum == SIGUSR2)
		c |= 1;
	n--;
	if (!n)
	{
		add_char_to_buffer(c);
		n = NB_SIG;
		c = 0;
	}
	if ((int)info->si_pid)
		last_pid = info->si_pid;
	kill(last_pid, SIGUSR1);
}

int	main(void)
{
	pid_t				pid;
	struct sigaction	act;

	pid = getpid();
	act.sa_handler = NULL;
	act.sa_sigaction = signal_handler;
	act.sa_mask = 0;
	act.sa_flags = SA_SIGINFO;
	sigaction(SIGUSR1, &act, NULL);
	sigaction(SIGUSR2, &act, NULL);
	ft_putstr("PID: ");
	ft_putnbr(pid);
	ft_putchar('\n');
	while (1)
		pause();
}
