using CX_Graphql.Models;
using CX_Identity.Models;
using Microsoft.EntityFrameworkCore;


namespace CX_Graphql.Data
{
    public class IdentityContext : DbContext
    {
        public IdentityContext(DbContextOptions<IdentityContext> options) : base(options)
        {

        }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Client>()
            .HasOne(b => b.ClientUIInfo)
            .WithOne(i => i.Client)
            .HasForeignKey<ClientUIInfo>(b => b.PublicKey);

            modelBuilder.Entity<Client>()
                .HasMany(p => p.Users)
                .WithOne(p => p.Client)
                .HasForeignKey(p => p.ClientGuid);

            modelBuilder.Entity<User>()
                .HasMany(p => p.UserClaims)
                .WithOne(p => p.Users)
                .HasForeignKey(b => b.UserGuid);

            modelBuilder.Entity<Client>().HasKey("PublicKey");
            modelBuilder.Entity<ClientUIInfo>().HasKey("PublicKey");
            modelBuilder.Entity<User>().HasKey("PublicKey");
            modelBuilder.Entity<UserClaims>().HasKey("PublicKey");
        }

        public DbSet<Client> Clients { get; set; }
        public DbSet<ClientUIInfo> ClientUIInfos { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<UserClaims> UserClaims {get; set;}
    }
}
