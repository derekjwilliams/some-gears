using System;
using System.ComponentModel.DataAnnotations;

namespace CX_Identity.Models
{
    public class ClientUIInfo
    {
        public int Id { get; set; } = 0;
        public string Theme { get; set; }
        public Guid PublicKey { get; set; }
        public Client Client { get; set; }
    }
}
