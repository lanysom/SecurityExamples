using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace TCPIPListener
{
    class Program
    {
        static void Main(string[] args)
        {

            TcpListener listener = new TcpListener(new IPAddress(new byte[] { 10, 112, 48, 173 }), 5555);
            listener.Start();

            Console.WriteLine("listening...");

            TcpClient conn = listener.AcceptTcpClient();
            var str = conn.GetStream();

            // Recieving thread
            Task.Run(() =>
            {
                do
                {
                    if (str.DataAvailable)
                    {
                        Console.Write((char)str.ReadByte());
                    }
                } while (true);
            });

            // Sending commands to remote
            do
            {

                var cmd = Console.ReadLine();
                str.Write(Encoding.ASCII.GetBytes(cmd), 0, cmd.Length);

            } while (true);



        }
    }
}
