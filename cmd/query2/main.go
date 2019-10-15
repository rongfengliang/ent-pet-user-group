package main

import (
	"context"
	"fmt"
	"log"

	_ "github.com/go-sql-driver/mysql"

	"github.com/rongfengliang/ent-pet-user-group/ent"
	"github.com/rongfengliang/ent-pet-user-group/ent/pet"
	"github.com/rongfengliang/ent-pet-user-group/ent/user"
)

func main() {
	client, err := ent.Open("mysql", "root:dalongrong@tcp(127.0.0.1)/gogs")
	if err != nil {
		log.Fatalf("failed opening connection to sqlite: %v", err)
	}
	defer client.Close()
	ctx := context.Background()
	Traverse(ctx, client.Debug())
}

// Traverse traverse
func Traverse(ctx context.Context, client *ent.Client) error {
	pets, err := client.Pet.
		Query().
		Where(
			pet.HasOwnerWith(
				user.HasFriendsWith(
					user.HasManage(),
				),
			),
		).
		All(ctx)
	if err != nil {
		return fmt.Errorf("failed querying the pets: %v", err)
	}
	fmt.Println(pets)
	// Output:
	// [Pet(id=1, name=Pedro) Pet(id=2, name=Xabi)]
	return nil
}
