(* Copyright (C) 2019--2021  Petter A. Urkedal <paurkedal@gmail.com>
 *
 * This library is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or (at your
 * option) any later version, with the LGPL-3.0 Linking Exception.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
 * License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * and the LGPL-3.0 Linking Exception along with this library.  If not, see
 * <http://www.gnu.org/licenses/> and <https://spdx.org>, respectively.
 *)

(** {b Internal:} Prerequisites.

    This module is meant for internal use by Caqti and may change in backwards
    incompatible ways between minor versions without prior notice. *)

val (%) : ('b -> 'c) -> ('a -> 'b) -> 'a -> 'c
val (%>) : ('a -> 'b) -> ('b -> 'c) -> 'a -> 'c
val (%>?) : ('a -> ('b, 'e) result) -> ('b -> ('c, 'e) result) ->
            'a -> ('c, 'e) result
val (|>?) : ('a, 'e) result -> ('a -> ('b, 'e) result) -> ('b, 'e) result

val ident : 'a -> 'a
val ncompose : int -> ('a -> 'a) -> 'a -> 'a

module Option : sig
  type 'a t = 'a option
  val map : ('a -> 'b) -> 'a option -> 'b option
  val fold : ('a -> 'b -> 'b) -> 'a option -> 'b -> 'b
end

module Result : sig
  val map : ('a -> 'b) -> ('a, 'c) result -> ('b, 'c) result
end

module List : sig
  include module type of List
  val fold : ('a -> 'b -> 'b) -> 'a list -> 'b -> 'b
  val fold_r : ('a -> 'b -> ('b, 'e) result) -> 'a list -> 'b -> ('b, 'e) result
  val iter_r : ('a -> (unit, 'e) result) -> 'a list -> (unit, 'e) result
  val iteri_r : (int -> 'a -> (unit, 'e) result) -> 'a list -> (unit, 'e) result
  val equal : ('a -> 'b -> bool) -> 'a list -> 'b list -> bool
end

val finally : (unit -> unit) -> (unit -> 'a) -> 'a

val datetuple_of_iso8601 : string -> int * int * int
val iso8601_of_datetuple : int * int * int -> string

val ptime_of_rfc3339_utc : string -> (Ptime.t, string) result

val pdate_of_iso8601 : string -> (Ptime.t, string) result
val iso8601_of_pdate : Ptime.t -> string

val default_log_src : Logs.Src.t
val request_log_src : Logs.Src.t

module Alog : Logs.LOG
