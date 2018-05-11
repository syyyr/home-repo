import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        System.out.println("Zadejte hodnotu zelene sipky:");
        int zelena = in.nextInt();
        System.out.println("Zadejte hodnotu zlute sipky:");
        int zluta = in.nextInt();
        System.out.println("Zadejte hodnotu cervene sipky:");
        int cervena = in.nextInt();
        System.out.println("Zadejte velikost mrizky: (vyska sirka)");
        int vyska = in.nextInt();
        int sirka = in.nextInt();
        int[][] mrizka = new int[vyska][sirka];
        System.out.println("Zadejte mrizku ve formatu:");
        for (int i = 0; i < vyska; i++)
        {
            for (int j = 0; j < sirka; j++)
                System.out.print("n ");

            System.out.println();
        }

        System.out.println("Neznama cisla zadejte otaznikem");

        for (int i = 0; i < vyska; i++)
        {
            for (int j = 0; j < sirka; j++)
            {
                if(in.hasNextInt())
                {
                    mrizka[i][j] = in.nextInt();
                }
                else if(in.next() == "?")
                {
                    mrizka[i][j] = Integer.MAX_VALUE;
                }
            }
        }


        System.out.println("Zadejte pocet sipek: ");
        int pocet_sipek = in.nextInt();
        String[][] sipky = new String[vyska][sirka];
        for (int i = 0; i < vyska; i++)
            for (int j = 0; j < sirka; j++)
                sipky[i][j] = "";
        System.out.println("Zadejte pozice sipek ve formatu: (x y smer barva) (smer=nahoru dolu doleva doprava) (barva=zelena zluta cervena)");

        for (int i = 0; i < pocet_sipek; i++)
        {
            int x = in.nextInt();
            int y = in.nextInt();
            String smer = in.next();
            if (!smer.equals("nahoru") && !smer.equals("dolu") && !smer.equals("doleva") && !smer.equals("doprava"))
            {
                System.out.println("neplatny smer");
                return;
            }
            if (x == 0 && smer.equals("nahoru"))
            {
                System.out.println("neplatna sipka");
                return;
            }
            if (x == vyska && smer.equals("dolu"))
            {
                System.out.println("neplatna sipka");
                return;
            }

            if (y == 0 && smer.equals("doleva"))
            {
                System.out.println("neplatna sipka");
                return;
            }
            if (y == sirka && smer.equals("doprava"))
            {
                System.out.println("neplatna sipka");
                return;
            }

            String barva = in.next();

            if (!barva.equals("cervena") && !barva.equals("zelena") && !barva.equals("zluta"))
            {
                System.out.println("neplatna barva");
                return;
            }

            sipky[x][y] = smer + " " + barva;
        }

        for (int i = 0; i < vyska; i++)
        {
            for (int j = 0; j < sirka; j++)
            {
                if (sipky[i][j].equals(""))
                    continue;
                String smer_sipky = (sipky[i][j].split(" "))[0];
                String barva_sipky = (sipky[i][j].split(" "))[1];

                int cilove_x = i;
                int cilove_y = j;
                switch (smer_sipky)
                {
                    case "nahoru":
                        cilove_x -= 1;
                        break;
                    case "dolu":
                        cilove_x += 1;
                        break;
                    case "doleva":
                        cilove_y -= 1;
                        break;
                    case "doprava":
                        cilove_y += 1;
                        break;
                }

                int vysledek = mrizka[i][j];

                switch (barva_sipky)
                {
                    case "zelena":
                        vysledek += zelena;
                        break;
                    case "zluta":
                        vysledek += zluta;
                        break;
                    case "cervena":
                        vysledek += cervena;
                        break;

                }
                mrizka[cilove_x][cilove_y] = vysledek;
            }
        }

        for (int i = 0; i < vyska; i++)
        {
            for(int j = 0; j < sirka; j++)
                System.out.print(mrizka[i][j] + " ");
            System.out.println();

        }

    }
}

