package main

import (
	"context"
	"fmt"
	"log"

	_ "github.com/go-sql-driver/mysql"

	"github.com/rongfengliang/ent-pet-user-group/ent"
	"github.com/rongfengliang/ent-pet-user-group/ent/group"
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
	owner, err := client.Group. // GroupClient.
					Query().                     // Query builder.
					Where(group.Name("Github")). // Filter only Github group (only 1).
					QueryAdmin().                // Getting Dan.
					QueryFriends().              // Getting Dan's friends: [Ariel].
					QueryPets().                 // Their pets: [Pedro, Xabi].
					QueryFriends().              // Pedro's friends: [Coco], Xabi's friends: [].
					QueryOwner().                // Coco's owner: Alex.
					Only(ctx)                    // Expect only one entity to return in the query.
	if err != nil {
		return fmt.Errorf("failed querying the owner: %v", err)
	}
	fmt.Println(owner)
	return nil
}
