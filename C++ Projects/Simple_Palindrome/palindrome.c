#include <stdio.h>
#include <string.h>

int main() {
    
    char x[100];
    
    
    scanf("%s",x);
    int length;
    int character;
    int i = 0;
    
    length = strlen(x);
    character = length - 1;
    int nonpalindrome = 1;
    
    for(i; i < length; i++)
    {
        if(i == character)
        {
            break;
        }
        //printf("%c",x[i]);
        //printf("%c",x[character]);

        if(x[i] != x[character])
        {
            nonpalindrome = 0;
            break;
        }
        
        character--;
    }
    
    if(nonpalindrome == 0)
    {
        //int newlength = ((length * 2) - 1);
        printf("\nNot a palindrome.\n");
        return 0;
        
    }
    
    if(nonpalindrome == 1)
    {
        printf("\nIs a palindrome.\n");
    }
    
    //int newlength = ((length * 2) - 1);
     
    //printf("%c",x[0]);
    
    

    return 0;
}
