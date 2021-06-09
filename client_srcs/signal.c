#include "master.h"

int	received_signal(int set_to_true)
{
	static int	received = 0;

	if (set_to_true)
		received = 1;
	else if (received)
	{
		received = 0;
		return (1);
	}
	return (0);
}

void	client_signal_handler(int signum)
{
	if (signum == SIGUSR1)
		received_signal(1);
}
