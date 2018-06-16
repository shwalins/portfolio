import java.util.*;
import java.io.*;

public class driver
{

    public static void main(String args[])
    {
        MergeSort mergeSort = new MergeSort();
        int[] TestArray = {9,7,3,4,5,1,500,0,8,21,99,11};
        TestArray = mergeSort.preSort(TestArray);
        System.out.println(Arrays.toString(TestArray));


    }


}
