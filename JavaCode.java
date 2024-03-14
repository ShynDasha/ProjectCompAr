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

        // З'єднує в одну стрічку відсортовані бінарні числа з бітом 1, а потім з бітом 0
         String combinedBinaryNumbers = combineBinaryNumbers(sortedBinaryNumbersWithB1, sortedBinaryNumbersWithB0);
         System.out.println("Відсортовані усі значення");
         System.out.println(combinedBinaryNumbers);

         List<Integer> decimalNumbers = binaryToDecimal(combinedBinaryNumbers);

         // Обчислюємо середнє значення
         double average = calculateAverage(decimalNumbers);
         System.out.println("Середнє значення: " + average);
 
         // Обчислюємо медіану
         double median = calculateMedian(decimalNumbers);
         System.out.println("Медіана: " + median);

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

    private static String combineBinaryNumbers(List<String> binaryNumbersWithMSB1, List<String> binaryNumbersWithMSB0) {
        StringBuilder combined = new StringBuilder();
        for (String binary : binaryNumbersWithMSB1) {
            combined.append(binary).append(" ");
        }
        for (String binary : binaryNumbersWithMSB0) {
            combined.append(binary).append(" ");
        }
        return combined.toString();
    }

  // Перетворює бінарне число у відповідне десяткове значення
  public static int convertBinaryToDecimal(String binary) {
    if (binary == null || binary.isEmpty()) {
        return 0;
    }
    boolean isNegative = binary.charAt(0) == '1';

    if (!isNegative) {
        return Integer.parseInt(binary, 2);
    } else {

        // Перетворює об'єднану бінарну стрічку в список десяткових чисел
        String invertedBinary = binary
                .substring(1)
                .replace('0', '2')
                .replace('1', '0')
                .replace('2', '1');

        int decimalValue = Integer.parseInt(invertedBinary, 2) + 1;

        return -decimalValue;
    }
}

// Перетворює об'єднану бінарну стрічку в список десяткових чисел
private static List<Integer> binaryToDecimal(String combinedBinaryNumbers) {
    List<Integer> decimalNumbers = new ArrayList<>();
    String[] binaryTokens = combinedBinaryNumbers.trim().split("\\s+");
    for (String binary : binaryTokens) {
        int decimal = convertBinaryToDecimal(binary);
        decimalNumbers.add(decimal);
    }
    return decimalNumbers;
}

    
    //для обчислення медіани з відсортованого списку
    private static double calculateMedian(List<Integer> numbers) {
        Collections.sort(numbers);
        int size = numbers.size();
        if (size % 2 == 0) {
            int midIndex = size / 2;
            return (double) (numbers.get(midIndex - 1) + numbers.get(midIndex)) / 2;
        } else {
            return numbers.get(size / 2);
        }
    }
    
    //для обчислення середнього значення бінарних чисел
    private static double calculateAverage(List<Integer> numbers) {
        double sum = 0;
        for (int num : numbers) {
            sum += num;
        }
        return sum / numbers.size();
    }
    
}
