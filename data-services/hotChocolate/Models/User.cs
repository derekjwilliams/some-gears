using System;
using System.Collections.Generic;
using CX_Graphql.Models;

namespace CX_Identity.Models
{
    /// <summary>
    /// This is a User for Concentrex User Mangement
    /// </summary>
    public class User
    {
        public int Id { get; set; } = 0;
        /// <summary>
        /// Concentrex User Name
        /// </summary>
        public string UserName { get; set; } = null;
        public bool Enabled { get; set; }
        /// <summary>
        /// a unique identifier for the user =>Guid
        /// </summary>
        public Guid PublicKey { get; set; }
        /// <summary>
        /// the user id for the Identity server to verify 
        /// </summary>
        public string IdentityProviderUserId { get; set; } = null;
        public int InvalidLoginAttempts { get; set; }
        /// <summary>
        /// if the user is locked password reset is required
        /// </summary>
        public bool IsLocked { get; set; }
        public DateTime CreatedOn { get; set; }
        public DateTime LastChangedOn { get; set; }
        public int IdentityProviderId { get; set; }
        /// <summary>
        /// The Client Id this user belongs to
        /// </summary>
        public int ClientId { get; set; }
        /// <summary>
        /// flag for if this user is only used for testing
        /// </summary>
        public bool? TestAccount { get; set; }
        /// <summary>
        /// flag if the user is managed manually
        /// </summary>
        public bool? IsManaged { get; set; }
        public Guid ClientGuid { get; set; }
        public Guid IdentityProviderGuid { get; set; }

        public Client Client { get; set; }
        public ICollection<UserClaims> UserClaims {get; set;}
    }
}
