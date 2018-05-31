my @kokot = "'title': q";
my @pica = grep { /'title': q(?!',)/ } @kokot; #mathne
my @curak = "'title': q'";
my @zmrd = grep { /'title': q(?!',)/ } @curak; #matchne
my @hovno = "'title': q',";
my @kurva = grep { /'title': q(?!',)/ } @hovno; #nematchne
