SELECT
    DISTINCT `users`.`id`,
    `users`.`age`,
    `users`.`name`
FROM
    `users`
    JOIN (
        SELECT
            `pets`.`owner_id`
        FROM
            `pets`
            JOIN (
                SELECT
                    `pet_friends`.`friend_id`
                FROM
                    `pet_friends`
                    JOIN (
                        SELECT
                            `pets`.`id`
                        FROM
                            `pets`
                            JOIN (
                                SELECT
                                    `users`.`id`
                                FROM
                                    `users`
                                    JOIN (
                                        SELECT
                                            `user_friends`.`friend_id`
                                        FROM
                                            `user_friends`
                                            JOIN (
                                                SELECT
                                                    `users`.`id`
                                                FROM
                                                    `users`
                                                    JOIN (
                                                        SELECT
                                                            `groups`.`admin_id`
                                                        FROM
                                                            `groups`
                                                        WHERE
                                                            `groups`.`name` = 'Github'
                                                    ) AS `t1` ON `users`.`id` = `t1`.`admin_id`
                                            ) AS `t1` ON `user_friends`.`user_id` = `t1`.`id`
                                    ) AS `t1` ON `users`.`id` = `t1`.`friend_id`
                            ) AS `t1` ON `pets`.`owner_id` = `t1`.`id`
                    ) AS `t1` ON `pet_friends`.`pet_id` = `t1`.`id`
            ) AS `t1` ON `pets`.`id` = `t1`.`friend_id`
    ) AS `t1` ON `users`.`id` = `t1`.`owner_id`