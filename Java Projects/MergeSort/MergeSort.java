import java.util.*;

public class MergeSort 
{


    public static int[] preSort(int [] TestArray)
    {
        //int[] TestArray = {9,7,3,4,5,1,0,8,21,99,11};
        int[] tempArray = new int [TestArray.length];
        sortStart(TestArray, tempArray, 0, TestArray.length - 1);
        //System.out.println(Arrays.toString(TestArray));
        return (TestArray);
    }

    public static void sortStart (int [] origAr, int [] temp, int left, int right)
    {
        if (left < right)
        {
            int middle = (left + right) / 2;
            sortStart(origAr, temp, left, middle);
            sortStart(origAr, temp, middle + 1, right);
            mergeStart(origAr, temp, left, middle + 1, right);
        }
    }

    public static void mergeStart(int [] origAr, int [] temp, int left, int right, int rightEnd)
    {
        int leftEnd = right - 1;
        int k = left;
        int num = rightEnd - left + 1;

        while(left <= leftEnd && right <= rightEnd)
            if((origAr[left] <= origAr[right]))
                temp[k++] = origAr[left++];
            else
                temp[k++] = origAr[right++];

        while(left <= leftEnd)
            temp[k++] = origAr[left++];

        while(right <= rightEnd)
            temp[k++] = origAr[right++];

          for(int i = 0; i < num; i++, rightEnd--)
            origAr[rightEnd] = temp[rightEnd];      

    }
/*
    private static void mergeSort(int temp[])
    {
        if (left < right)
        {
                int middle = (left + right) / 2;
                mergeSort();

        }


    }

*/
}