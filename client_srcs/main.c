#include "master.h"

int	main(int argc, char **argv)
{
	pid_t	serv_pid;

	if (argc != 3)
	{
		ft_putstr("You must enter two arguments\n");
		return (0);
	}
	serv_pid = ft_atoi(argv[1]);
	if ((int)serv_pid == 0)
	{
		ft_putstr("Bad PID\n");
		return (0);
	}
	signal(SIGUSR1, client_signal_handler);
	if (send_str(serv_pid, argv[2]))
		ft_putstr("A signal failed to be sent\n");
	else
		ft_putstr("Message sent!\n");
}
