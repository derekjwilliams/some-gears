using System;
using System.Collections.Generic;

namespace CX_Identity.Models
{
    public class Client
    {
        public int Id { get; set; } = 0;
        public Guid PublicKey { get; set; }
        public string Name { get; set; } = null;
        public string FilesharePath { get; set; } = null;
        public DateTime CreatedOn { get; set; }
        public DateTime LastUpdatedOn {get; set; }
        public ClientUIInfo ClientUIInfo { get; set; }
        public ICollection<User> Users { get; set; }
    }
}
