#include "master.h"

static void	print_buffer(char **buf_ptr, long *len_ptr)
{
	write(1, *buf_ptr, *len_ptr);
	free(*buf_ptr);
	*buf_ptr = NULL;
	*len_ptr = 0;
}

static void	extend_buffer(char **buf_ptr, long len)
{
	char	*temp;
	long	i;

	i = 0;
	temp = malloc(sizeof(*temp) * (len + BUFFER_SIZE));
	if (temp == NULL)
	{
		if (*buf_ptr)
			free(*buf_ptr);
		ft_putstr("\nERROR: Malloc function failed\n");
		exit(1);
	}
	while (i < len)
	{
		temp[i] = (*buf_ptr)[i];
		i++;
	}
	if (*buf_ptr)
		free(*buf_ptr);
	*buf_ptr = temp;
}

void	add_char_to_buffer(char c)
{
	static char	*buf = NULL;
	static long	len = 0;

	if (!c && len)
		print_buffer(&buf, &len);
	else if (c)
	{
		if ((len % BUFFER_SIZE) == 0)
			extend_buffer(&buf, len);
		buf[len] = c;
		len++;
	}
}
