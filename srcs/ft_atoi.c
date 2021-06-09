#include "master.h"

int	ft_atoi(char *s)
{
	int	ret;

	ret = 0;
	while (*s)
	{
		ret = ret * 10 + *s - '0';
		if (*s < '0' || *s > '9' || ret < 0)
			return (0);
		s++;
	}
	return (ret);
}
