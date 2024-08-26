dotnet add package System.Management
using System;
using System.Management;
using System.Printing;
using System.Linq;

namespace HardwareAndPeripheralInfo
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Gathering System Hardware and Peripheral Information...");

            // System Hardware Information
            Console.WriteLine("System Hardware Information:");
            GetSystemHardwareInfo();

            // Peripherals Information
            Console.WriteLine("\nConnected Peripherals Information:");
            GetPeripheralsInfo();

            Console.WriteLine("\nPress any key to exit...");
            Console.ReadKey();
        }

        static void GetSystemHardwareInfo()
        {
            // CPU Information
            Console.WriteLine("CPU Information:");
            foreach (var item in GetWmiObjects("Win32_Processor"))
            {
                Console.WriteLine($"- {item["Name"]}");
            }

            // Memory Information
            Console.WriteLine("\nMemory Information:");
            foreach (var item in GetWmiObjects("Win32_PhysicalMemory"))
            {
                Console.WriteLine($"- {item["Capacity"]} bytes");
            }

            // Disk Information
            Console.WriteLine("\nDisk Information:");
            foreach (var item in GetWmiObjects("Win32_DiskDrive"))
            {
                Console.WriteLine($"- {item["DeviceID"]} | {item["Size"]} bytes");
            }

            // Network Adapters Information
            Console.WriteLine("\nNetwork Adapters Information:");
            foreach (var item in GetWmiObjects("Win32_NetworkAdapter"))
            {
                Console.WriteLine($"- {item["Name"]} | {item["MACAddress"]}");
            }
        }

        static void GetPeripheralsInfo()
        {
            // Printer Information
            Console.WriteLine("Printers:");
            var printServer = new PrintServer();
            var printQueues = printServer.GetPrintQueues(new[] { EnumeratedPrintQueueTypes.Local, EnumeratedPrintQueueTypes.Connections });
            foreach (var queue in printQueues)
            {
                Console.WriteLine($"- {queue.Name}");
            }

            // For Wacom tablets, you might need to use specific vendor APIs or libraries.
            // Example: Enumerate HID devices if using raw HID APIs.
        }

        static ManagementObjectCollection GetWmiObjects(string className)
        {
            using (var searcher = new ManagementObjectSearcher($"SELECT * FROM {className}"))
            {
                return searcher.Get();
            }
        }
    }
}
