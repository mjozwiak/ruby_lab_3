//Malgorzata Jozwiak grupa B 215559
//algorytmy dopasowujace wzorzec do tekstu
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>
#define MLD 1000000000.0 //10**9

int rozm(char *nazwa)
{
    FILE *plik=fopen(nazwa,"r");
    if (plik==NULL)
    {
        printf("Nie mozna znalezc pliku %s\n",nazwa);
        return -1;
    }
    else
    {
        fseek(plik,0,SEEK_END);
        int konc=ftell(plik);
        fclose(plik);
        return konc;//-pocz;
    }
}

char* wczytaj_wzorzec(char *nazwa, int *iloscznakow)//funkcja wczytujaca z pamieci wzorzec z pliku
{
    int rzm=rozm(nazwa);
    if(rzm==-1)
        return NULL;
    char wzrz[rzm+1];
    FILE *plik=fopen(nazwa,"r");
    int i=0,j=0;
    int lic=0;
    int znaki[128];
    for(i=0;i<128;i++)
        znaki[i]=0;
    i=0;
    while(i<rzm)
    {
        wzrz[j]=fgetc(plik);
        znaki[wzrz[j]]++;
        if(wzrz[j]==10)//jesli znak jest znakiem nowego wiersza, ignorujemy go
            {
                j--;
                lic++;}
        j++;
        i++;

    }
    for(i=0;i<128;i++)
        if(znaki[i]!=0) printf("%c %d ",i,i);
    wzrz[j]='\0';
    *iloscznakow=strlen(wzrz);
    fclose(plik);
    return strdup(wzrz);//duplikuje string-bez tego mozliwe jest nadpisywanie danych

}

void brute(char *wzorzec, char *tekst,int dlwzr, int dltxt)
{
    int i,j;
    for(i=0;i<dltxt-dlwzr;i++)//zaczynamy od kazdej kolejnej literki w tekscie
    {
         j=0;
         while(j<dlwzr)//po kazdej kolejnej literce we wzorcu
         {

            if(wzorzec[j]==tekst[i+j])
                j++;
            else break;
         }
         if(j==dlwzr)
         {
             printf("\nWzorzec znaleziony na pozycji %d\n",i);
             i=i+j;
         }
    }
}

//d-rozmiar alfabetu, q-liczba pierwsza
void robin_karp(char *wzorzec, char* tekst,int d,int q, int rozmWzorzec,int rozmTekst)
{
    int w=0,t=0,i,j,t1;
    int h=1;
    for(i=0;i<rozmWzorzec-1;i++)
    {
        h=(h*d)%q;
    }
    for(i=0;i<rozmWzorzec;i++)
    {
        w=(d*w+wzorzec[i])%q;
        t=(d*t+tekst[i])%q;
    }
    for(i=0;i<rozmTekst-rozmWzorzec;i++)
    {
        if(w==t)
        {
            j=0;
            while(j<rozmWzorzec)
            {
                if(wzorzec[j]==tekst[i+j])//co tutaj dac
                    j++;
                else
                    break;
            }
            if(j==rozmWzorzec)
                 printf("\nWzorzec znaleziony na pozycji %d\n",i);
        }
        t1=(tekst[i]*h)%q;
        if(t<t1)
            t=t+q;
        t=(d*(t-t1)+tekst[i+rozmWzorzec])%q;
    }
}

/*
* funkcja obliczajaca dla kazdego znaku z wzorca jaki jest ciag znakow powtarzajacych sie z poczatkiem wzorca
*/
void compute_prefix(char *wzorzec, int *pi)//funkcja pomocnicza do algorytmu knuth morris pratt
{
    int m=strlen(wzorzec);
    pi[0]=0;
    int k=0,q;
    for(q=1;q<m;q++)
    {
        while(k>0&&wzorzec[q]!=wzorzec[k])
        {
            k=pi[k];
        }
        if(wzorzec[k]==wzorzec[q])
            k=k+1;
        pi[q]=k;
    }
}

void knuth_morris_pratt(char *wzorzec, char* tekst)
{
    int n=strlen(tekst);
    int m=strlen(wzorzec);
    int pi[m];
    compute_prefix(wzorzec,pi);

    int q=0,i;
    for(i=0;i<n;i++)
    {
        while(q>0 && tekst[i]!=wzorzec[q+1])
        {
            q=pi[q];
        }
        if(tekst[i]==wzorzec[q+1])
            q++;
        if(q==m-1)
        {
            printf("\nWzorzec znaleziony na pozycji %d\n",i-q);
            q=pi[q];
        }
    }

}

int compute_transaction_function(char *wzorzec, char current, int *pi, int stan)//current-znak, ktory w tej chwili
{
    int m=strlen(wzorzec);
    if(stan==m-1 || current!=wzorzec[stan])
    {
        return pi[stan]+1;
    }
    else
    {
        return stan+1;
    }
}

void automation_matcher(char *wzorzec, char *tekst)
{
    int n=strlen(tekst);
    int m=strlen(wzorzec);
    int pi[m];
    compute_prefix(wzorzec,pi);//potrzebne do obliczania sigma
    int stan=0,i;//ustalamy poczatkowy stan automatu-0;
    for(i=0;i<n;i++)
    {

        stan=compute_transaction_function(wzorzec,tekst[i],pi,stan);
        if(stan==m-1)
            printf("\ni=%d, stan=%d, Wzorzec znaleziony na pozycji %d\n",i,stan,i+1-stan);
    }
}
int main()
{
    // kompilowac z opcjami -lrt -lm: gcc L1.c -lrt -lm ??
    int rozmWzorzec,rozmTekst;
//    struct timespec tp0, tp1;
    double T;
    char *wzorzec=wczytaj_wzorzec("wzorzec.txt",&rozmWzorzec);
    char *tekst=wczytaj_wzorzec("tekst.txt",&rozmTekst);

    printf("Brute Force:\n");
    //clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&tp0);
    brute(wzorzec,tekst,rozmWzorzec,rozmTekst);
   /* clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&tp1);
    T=(tp1.tv_sec+tp1.tv_nsec/MLD)-(tp0.tv_sec+tp0.tv_nsec/MLD);
    printf("czas: %3.5lf\n\n\n",T);*/

    printf("Robin Karp:\n");
   // clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&tp0);
    robin_karp(wzorzec,tekst,26,11897,rozmWzorzec,rozmTekst);
   /* clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&tp1);
    T=(tp1.tv_sec+tp1.tv_nsec/MLD)-(tp0.tv_sec+tp0.tv_nsec/MLD);
    printf("czas: %3.5lf\n\n\n",T);*/

    printf("Knuth Morris Pratt:\n");
  //  clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&tp0);
    knuth_morris_pratt(wzorzec,tekst);
   /* clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&tp1);
    T=(tp1.tv_sec+tp1.tv_nsec/MLD)-(tp0.tv_sec+tp0.tv_nsec/MLD);
    printf("czas: %3.5lf\n\n\n",T);*/

    printf("Automation Matcher:\n");
   // clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&tp0);
    automation_matcher(wzorzec,tekst);
   /* clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&tp1);
    T=(tp1.tv_sec+tp1.tv_nsec/MLD)-(tp0.tv_sec+tp0.tv_nsec/MLD);
    printf("czas: %3.5lf\n\n\n",T);*/
    return 0;
}
