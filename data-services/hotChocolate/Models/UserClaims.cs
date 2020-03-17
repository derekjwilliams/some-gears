using System;
using CX_Identity.Models;

namespace CX_Graphql.Models
{
    public class UserClaims
    {
        public int Id { get; set; } = 0;
        public int UserID { get; set; } = 0;
        public string Type { get; set; }
        public string Value { get; set; }
        public DateTime LastUpdated { get; set; }
        public Guid? UserGuid { get; set; }
        public Guid PublicKey { get; set; }
        public Guid ClientGuid { get; set; }

        public User Users { get; set; }
    }
}
