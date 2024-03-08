import java.util.*;

public class JavaCode {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        List<Integer> numbers = new ArrayList<>();

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
                numbers.add(num);
            }
        }
        scanner.close();

        // переведення десяткових чисел у бінарне представлення
        List<String> binaryNumbers = new ArrayList<>();
        for (int num : numbers) {
            binaryNumbers.add(decimalToBinary(num));

        }
        for (String binaryNum : binaryNumbers) { //виводить кожне число в бінарному вигляді
            System.out.println(binaryNum);
        }


        // cортування за допомогою алгоритму сортування злиттям
        mergeSort(binaryNumbers, 0, binaryNumbers.size() - 1);

        // Обчислення медіани
        int median = calculateMedian(binaryNumbers);
        System.out.println("Медіана : " + median);


        // Обчислення середнього значення
        double average = calculateAverage(binaryNumbers);
        System.out.println("Середнє значенння: " + average);
    }

    // для конвертації десяткового числа у бінарне представлення
    private static String decimalToBinary(int num) {
        String binary = Integer.toBinaryString(num);
        StringBuilder paddedBinary = new StringBuilder(binary);
        while (paddedBinary.length() < 16) {
            paddedBinary.insert(0, '0');
        }
        return paddedBinary.toString();
    }

    // Метод для сортування списку рядків за допомогою алгоритму сортування злиттям
    private static void mergeSort(List<String> arr, int left, int right) {
        if (left < right) {
            int mid = (left + right) / 2;
            mergeSort(arr, left, mid);
            mergeSort(arr, mid + 1, right);
            merge(arr, left, mid, right);
        }
    }

    // сортування злиттям
    private static void merge(List<String> arr, int left, int mid, int right) {
        List<String> leftPart = new ArrayList<>(arr.subList(left, mid + 1));
        List<String> rightPart = new ArrayList<>(arr.subList(mid + 1, right + 1));

        int i = 0, j = 0, k = left;
        while (i < leftPart.size() && j < rightPart.size()) {
            if (leftPart.get(i).compareTo(rightPart.get(j)) <= 0) {
                arr.set(k++, leftPart.get(i++));
            } else {
                arr.set(k++, rightPart.get(j++));
            }
        }

        while (i < leftPart.size()) {
            arr.set(k++, leftPart.get(i++));
        }

        while (j < rightPart.size()) {
            arr.set(k++, rightPart.get(j++));
        }
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
