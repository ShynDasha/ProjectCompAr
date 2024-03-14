import java.util.*;

public class JavaCode {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        scanner.useDelimiter("\r\n|[\r\n]");
        List<String> binaryNumbersWithMSB1 = new ArrayList<>();
        List<String> binaryNumbersWithMSB0 = new ArrayList<>();

        System.out.println("Введіть N десяткових чисел ");
        //зчитування чисел
        while (scanner.hasNextLine()) {
            String line = scanner.nextLine();
            if (line.isEmpty()) {
                break;
            }
            String[] tokens = line.trim().split("\\s+");
            for (String token : tokens) {
                int num = Integer.parseInt(token);
                String binary = decimalToBinary(num);
                if (binary.charAt(0) == '1') {
                    binaryNumbersWithMSB1.add(binary);
                } else {
                    binaryNumbersWithMSB0.add(binary);
                }
            }
        }
        scanner.close();

        List<String> sortedBinaryNumbersWithB1 = mergeSort(binaryNumbersWithMSB1);
        List<String> sortedBinaryNumbersWithB0 = mergeSort(binaryNumbersWithMSB0);


        System.out.println("Відсортовані бінарні значення зі старшим бітом 1(від'ємні): ");
        for (String binary : sortedBinaryNumbersWithB1) {
            System.out.println(binary);
        }
        System.out.println("Відсортовані бінарні значення зі старшим бітом 0(додатні):");
        for (String binary : sortedBinaryNumbersWithB0) {
            System.out.println(binary);
        }


        // cортування за допомогою алгоритму сортування злиттям
      

        // Обчислення медіани
    }

    // для конвертації десяткового числа у бінарне представлення
    private static String decimalToBinary(int num) {
       StringBuilder binary = new StringBuilder();
       for (int i=0; i<16; i++){
        binary.insert(0, num & 1);
        num >>=1;
       }
        return binary.toString();
    }

     // Застосовує алгоритм сортування злиттям для сортування списку стрічок
     private static List<String> mergeSort(List<String> arr) {
        if (arr.size() <= 1) {
            return arr;
        }
        int mid = arr.size() / 2;
        List<String> left = mergeSort(arr.subList(0, mid));
        List<String> right = mergeSort(arr.subList(mid, arr.size()));
        return merge(left, right);
    }

    // сортування злиттям
    private static List<String> merge(List<String> left, List<String> right) {
        List<String> merged = new ArrayList<>();
        int leftIndex = 0, rightIndex = 0;
        while (leftIndex < left.size() && rightIndex < right.size()) {
            if (left.get(leftIndex).compareTo(right.get(rightIndex)) <= 0) {
                merged.add(left.get(leftIndex++));
            } else {
                merged.add(right.get(rightIndex++));
            }
        }
        merged.addAll(left.subList(leftIndex, left.size()));
        merged.addAll(right.subList(rightIndex, right.size()));
        return merged;
    }

    //для обчислення медіани з відсортованого списку
    private static int calculateMedian(List<String> arr) {
        int n = arr.size();
        if (n % 2 == 0) {
            String num1 = arr.get(n / 2);
            String num2 = arr.get(n / 2 - 1);
            int decimal1 = Integer.parseInt(num1, 2);
            int decimal2 = Integer.parseInt(num2, 2);
            return (decimal1 + decimal2) / 2;
        } else {
            String num = arr.get(n / 2);
            return Integer.parseInt(num, 2);
        }
    }
    
    //для обчислення середнього значення бінарних чисел
    private static double calculateAverage(List<String> arr) {
        double sum = 0;
        for (String num : arr) {
            sum += Integer.parseInt(num, 2);
        }
        return sum / arr.size();
    }
    
}
